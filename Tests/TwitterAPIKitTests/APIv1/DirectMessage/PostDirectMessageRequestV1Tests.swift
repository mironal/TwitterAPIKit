import TwitterAPIKit
import XCTest

class PostDirectMessageRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testText() throws {
        let req = PostDirectMessageRequestV1(
            targetUserID: "target",
            message: "msg"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.path, "/1.1/direct_messages/events/new.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "event": [
                    "type": "message_create",
                    "message_create": [
                        "message_data": ["text": "msg"],
                        "target": ["recipient_id": "target"],
                    ],
                ]
            ])
    }

    func testQuickReplyOptions() throws {
        let req = PostDirectMessageRequestV1(
            targetUserID: "target",
            message: "msg",
            quickReplyOptions: [
                .init(label: "label", description: "label desc", metadata: "meta"),
                .init(label: "label 2", description: "label desc 2", metadata: "meta 2"),
            ]
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.path, "/1.1/direct_messages/events/new.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "event": [
                    "type": "message_create",
                    "message_create": [
                        "target": ["recipient_id": "target"],
                        "message_data": [
                            "text": "msg",
                            "quick_reply": [
                                "type": "options",
                                "options": [
                                    ["label": "label", "description": "label desc", "metadata": "meta"],
                                    ["label": "label 2", "description": "label desc 2", "metadata": "meta 2"],
                                ],
                            ],
                        ],
                    ],
                ]
            ])
    }

    func testAttachMedia() throws {
        let req = PostDirectMessageRequestV1(
            targetUserID: "target",
            message: "msg with media",
            attachment: .media("media_id")
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.path, "/1.1/direct_messages/events/new.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "event": [
                    "type": "message_create",
                    "message_create": [
                        "message_data": [
                            "text": "msg with media",
                            "attachment": [
                                "type": "media",
                                "media": [
                                    "id": "media_id"
                                ],
                            ],
                        ],
                        "target": ["recipient_id": "target"],
                    ],
                ]
            ])
    }

    func testAttachLocation() throws {
        XCTContext.runActivity(named: "coordinate") { _ in
            let req = PostDirectMessageRequestV1(
                targetUserID: "target",
                message: "msg",
                attachment: .location(.coordinate(.init(lat: 10, long: 20)))
            )

            XCTAssertEqual(req.method, .post)
            XCTAssertEqual(req.path, "/1.1/direct_messages/events/new.json")
            XCTAssertEqual(req.bodyContentType, .json)
            AssertEqualAnyDict(
                req.parameters,
                [
                    "event": [
                        "type": "message_create",
                        "message_create": [
                            "message_data": [
                                "text": "msg",
                                "attachment": [
                                    "type": "location",
                                    "location": [
                                        "type": "shared_coordinate",
                                        "shared_coordinate": [
                                            "coordinates": [
                                                "type": "Point",
                                                "coordinates": [10, 20],
                                            ]
                                        ],
                                    ],
                                ],
                            ],
                            "target": ["recipient_id": "target"],
                        ],
                    ]
                ])
        }

        XCTContext.runActivity(named: "place") { _ in
            let req = PostDirectMessageRequestV1(
                targetUserID: "target",
                message: "msg",
                attachment: .location(.place("place_id"))
            )

            XCTAssertEqual(req.method, .post)
            XCTAssertEqual(req.path, "/1.1/direct_messages/events/new.json")
            XCTAssertEqual(req.bodyContentType, .json)
            AssertEqualAnyDict(
                req.parameters,
                [
                    "event": [
                        "type": "message_create",
                        "message_create": [
                            "message_data": [
                                "text": "msg",
                                "attachment": [
                                    "type": "location",
                                    "location": [
                                        "type": "shared_place",
                                        "shared_place": [
                                            "place": [
                                                "id": "place_id"
                                            ]
                                        ],
                                    ],
                                ],
                            ],
                            "target": ["recipient_id": "target"],
                        ],
                    ]
                ])
        }
    }
}
