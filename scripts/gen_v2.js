
/**
 * @typedef {{type: string, name: string, rawName: string, required: boolean, kind: "path" | "query" | "json", swiftType?: string}} Prop
 */
// In Twitter's API documentation, paste it into the Chrome DevTools console and run it.

(function () {

    /**
     * @returns {{className: string, method: string}}
     */
    function createClassNameAndMethod() {
        const title = document.querySelector("h1").textContent
        const titleTokens = title.split("/")

        // GET /2/tweets/:id/retweeted_by -> GET /tweets/retweeted_by -> GetTweetsRetweetedByRequestV2
        const removed = titleTokens.filter(s => !s.startsWith(":") && s !== "2").join("/")
        const tokens = removed.replace(/([A-Z]+) /g, "$1/").replace("_", "/").split("/")
        let name = tokens.reduce((prev, current) => {
            const low = current.toLowerCase()
            return prev + low.charAt(0).toUpperCase() + low.slice(1);
        }, "").replace("Id", "ID")

        // GET /2/tweets     -> GetTweetsRequestV2 
        // GET /2/tweets/:id -> GetTweetRequestV2
        if (name.endsWith("s") && titleTokens[titleTokens.length - 1] === ":id") {
            name = name.slice(0, -1)
        }

        const className = name + "RequestV2"
        const method = tokens[0].toLowerCase()
        return { className, method }
    }


    function createURL() {
        const url = Array(...document.querySelectorAll("h3")).find(elem => elem.innerText === "Endpoint URL").nextElementSibling.textContent
        return url.split("/").map(s => {
            if (s.startsWith(":")) {
                const camel = s.replace(":", "").split("_").reduce((prev, current) => {
                    if (prev.length === 0) {
                        return current
                    }
                    return prev + current.charAt(0).toUpperCase() + current.slice(1)
                }, "").replace("Id", "ID")

                return "\\(" + camel + ")"
            }
            return s
        }).join("/")
    }

    /**
     * // Path parameters or Query parameters
     * @param {string} name 
     * @returns {HTMLTableRowElement[]}
     */
    function getParameterTableRows(name) {

        const pathParamHeading = Array(...document.querySelectorAll("h3")).find(elem => elem.innerText === name)
        if (!pathParamHeading) {
            return []
        }

        const maybeTable = pathParamHeading.nextElementSibling
        if (maybeTable instanceof HTMLTableElement) {
            return Array(...maybeTable.rows)
        }
        return []
    }


    /**
     * 
     * @param {Prop} prop 
     */
    function bindSwiftType(prop) {

        function toType() {

            if (prop.name === "ids" && prop.type === "string") {
                return "[String]"
            }

            if (prop.name === "expansions") {
                if (prop.type.includes("enum (attachments.poll_ids, attachments.media_keys")) {
                    return "Set<TwitterTweetExpansionsV2>"
                } else if (prop.type.includes("enum (pinned_tweet_id")) {
                    return "Set<TwitterUserExpansionsV2>"
                }
            }

            const nameToType = {
                "media.fields": "Set<TwitterMediaFieldsV2>",
                "place.fields": "Set<TwitterPlaceFieldsV2>",
                "poll.fields": "Set<TwitterPollFieldsV2>",
                "tweet.fields": "Set<TwitterTweetFieldsV2>",
                "user.fields": "Set<TwitterUserFieldsV2>",
            }

            // TODO: 
            /*
            {
    "name": "exclude",
    "rawName": "exclude",
    "type": "enum (retweets, replies)",
    "required": false,
    "kind": "query"
    }
            */

            const typeToSwiftType = {
                "integer": "Int",
                "string": "String",
                "date (ISO 8601)": "Date",
                "boolean": "Bool"
            }

            return nameToType[prop.rawName] ?? typeToSwiftType[prop.type]
        }
        const type = toType()
        if (type) {
            prop.swiftType = type
        } else {
            console.warn("Unkown type for", prop)
        }

        return prop
    }

    /**
     * @param {HTMLTableRowElement[]} rows 
     * @param {"path" | "query" | "json"} kind
     * @return {Prop[]}
     */
    function pickupProps(rows, kind) {
        return rows.slice(1).reduce((prev, row) => {

            const [nameElem, typeElem] = row.children
            const required = nameElem.querySelector("small").textContent.trim().toLowerCase() == "required"
            const type = typeElem.textContent
            const rawName = nameElem.querySelector("code").textContent
            const name = rawName.replace(/[_.]./g,
                function (s) {
                    return s.charAt(1).toUpperCase();
                }).replace("Id", "ID")

            const prop = {
                name,
                rawName,
                type,
                required,
                kind
            }
            bindSwiftType(prop)

            prev.push(prop)
            return prev
        }, [])
    }

    /**
     * 
     * @param {Prop} prop 
     */
    function swiftPropertyString(prop) {
        const type = prop.swiftType ?? "Unknown"
        const optional = prop.required ? "" : "?"
        const string = `public let ${prop.name}: ${type}${optional}`

        return string
    }

    /**
  * 
  * @param {Prop[]} props 
  */
    function createParameterFunc(props) {
        if (props.length === 0) {
            return `open var parameters: [String: Any] {
            return [:]
    }`
        }
        const body = props.map(prop => {
            const isPrimitiveType = prop.type === "string" || prop.type === "integer" || prop.type === "boolean"
            const isArray = prop.swiftType === "[String]" || prop.swiftType === "[Int]"
            const optional = prop.required ? "" : "?"
            const join = isArray ? `.joined(separator: ",")` : ""
            if (isPrimitiveType) {
                if (optional) {
                    return `${prop.name}.map { p["${prop.rawName}"] = $0${join} }`
                }
                return `p["${prop.rawName}"] = ${prop.name}${join}`
            } else {
                return `${prop.name}${optional}.bind(param: &p)`
            }
        })
        return `open var parameters: [String: Any] {
            var p = [String: Any]()
            ${body.join("\n            ")}
            return p
        }`
    }

    /**
     * 
     * @param {Prop[]} props 
     * @returns 
     */
    function createInitFunc(props) {

        const initParams = props.map(p => {
            const optional = p.required ? "" : "?"
            const defaultArg = p.required ? "" : " = .none"
            return `${p.name}: ${p.swiftType ?? "Unkown"}${optional}${defaultArg}`
        })

        const initBody = props.map(p => {
            return `self.${p.name} = ${p.name}`
        })

        return `public init(
            ${initParams.join(",\n            ")}
        ) {
            ${initBody.join("\n            ")}
        }`
    }

    const classNameAndMethod = createClassNameAndMethod()
    const url = createURL()

    const pathPropsMap = pickupProps(getParameterTableRows("Path parameters"), "path")
    const queryPropsMap = pickupProps(getParameterTableRows("Query parameters"), "query")
    const jsonPropsMap = pickupProps(getParameterTableRows("JSON body parameters"), "json")

    const props = [
        ...pathPropsMap.map(swiftPropertyString),
        ...queryPropsMap.map(swiftPropertyString),
        ...jsonPropsMap.map(swiftPropertyString)
    ]

    const bodyContentType = jsonPropsMap.length === 0 ? "" :
        `
    public var bodyContentType: BodyContentType {
        return .json
    }
`
    const parameterFunc = createParameterFunc([...queryPropsMap, ...jsonPropsMap])

    const initFunc = createInitFunc([...pathPropsMap, ...queryPropsMap, ...jsonPropsMap])

    const source = `import Foundation

/// ${location.href}
open class ${classNameAndMethod.className}: TwitterAPIRequest {

    ${props.join("\n    ")}

    public var method: HTTPMethod {
        return .${classNameAndMethod.method}
    }

    public var path: String {
        return "${url.replace("https://api.twitter.com", "")}"
    }
    ${bodyContentType}
    ${parameterFunc}

    ${initFunc}
}
`
    console.log(source)
    copy(source)
})()
