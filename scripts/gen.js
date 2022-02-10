
// In Twitter's API documentation, paste it into the Chrome DevTools console and run it.

(function () {

    const title = document.querySelector("h1").textContent
    // POST users/report_spam-> [POST/users/report/spam]
    const tokens = title.replace(/([A-Z]+) /g, "$1/").replace("_", "/").split("/")

    const method = tokens[0]

    const className = tokens.reduce((prev, current) => {
        const low = current.toLowerCase()
        return prev + low.charAt(0).toUpperCase() + low.slice(1);

    }, "").replace("Id", "ID") + "RequestV1"


    const url = document.querySelector("#resource-url").nextElementSibling.textContent

    const nameToTypeMap = {
        "count": "Int",
        "cursor": "String",
        "description": "String",
        "user": "TwitterUserIdentifierV1",
        "includeEntities": "Bool",
        "includeUserEntities": "Bool",
        "trimUser": "Bool",
        "maxID": "String",
        "sinceID": "String",
        "stringifyIDs": "Bool",
        "skipStatus": "Bool",
        "query": "String",
        "follow": "Bool",
    }

    const propsMap = Array(...document.querySelector("#parameters").nextElementSibling.rows).slice(1).reduce((prev, row) => {
        const [nameElem, requiredElem] = row.children
        const required = requiredElem.textContent
        const name = nameElem.textContent.replace(/_./g,
            function (s) {
                return s.charAt(1).toUpperCase();
            }).replace("Id", "ID")

        prev[name] = required
        return prev
    }, {})

    if (propsMap["userID"] && propsMap["screenName"]) {
        delete propsMap["userID"]
        delete propsMap["screenName"]
        propsMap["user"] = "required"
    }

    const props = Object.keys(propsMap)
        .sort((a, b) => a.length - b.length)
        .map(name => {
            const type = nameToTypeMap[name] ?? "Unknown"
            const optional = propsMap[name] === "required" ? "" : "?"
            return `public let ${name}: ${type}${optional}`
        })


    const source = `
    /// ${location.href}
    open class ${className}: TwitterAPIRequest {
    
        ${props.join("\n    ")}
    
        public var method: HTTPMethod {
            return .${method.toLowerCase()}
        }
        public var path: String {
            return "${url.replace("https://api.twitter.com", "")}"
        }
    
    }
    `
    console.log(source)
    copy(source)
})()

