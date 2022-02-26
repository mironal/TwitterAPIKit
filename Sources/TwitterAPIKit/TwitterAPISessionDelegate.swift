import Foundation

protocol TwitterAPISessionDelegatedTask {

    var taskIdentifier: Int { get }

    func append(chunk: Data)

    func complete(error: Error?)

    func releaseTask(_ block: @escaping () -> Void)
}

class TwitterAPISessionDelegate: NSObject, URLSessionDataDelegate {

    private var tasks = [Int /* taskIdentifier */: TwitterAPISessionDelegatedTask]()

    func appendAndResume(task: URLSessionTask) -> TwitterAPISessionJSONTask {

        let twTask = TwitterAPISessionDelegatedJSONTask(task: task)
        tasks[task.taskIdentifier] = twTask

        task.resume()

        return twTask
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {

        print("-----")
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("JOSON", json)
        } else {
            print("Not JSON", String(data: data, encoding: .utf8)!)
        }

        tasks[dataTask.taskIdentifier]?.append(chunk: data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

        guard let task = tasks[task.taskIdentifier] else { return }

        task.complete(error: error)
        task.releaseTask { [weak self] in
            self?.tasks[task.taskIdentifier] = nil
        }
    }
}
