import Foundation

protocol TwitterAPISessionDelegatedTask {

    var taskIdentifier: Int { get }

    func append(chunk: Data)

    func complete(error: Error?)
}

class TwitterAPISessionDelegate: NSObject, URLSessionDataDelegate {

    private var tasks = [Int /* taskIdentifier */: TwitterAPISessionDelegatedTask]()

    func appendAndResume(task: URLSessionTask) -> TwitterAPISessionJSONTask {

        let twTask = TwitterAPISessionDelegatedJSONTask(task: task)
        twTask.delegate = self
        tasks[task.taskIdentifier] = twTask

        task.resume()

        return twTask
    }

    func appendAndResumeStream(task: URLSessionTask) -> TwitterAPISessionDelegatedStreamTask {
        let twTask = TwitterAPISessionDelegatedStreamTask(task: task)
        tasks[task.taskIdentifier] = twTask
        task.resume()
        return twTask
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {

        tasks[dataTask.taskIdentifier]?.append(chunk: data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

        guard let task = tasks[task.taskIdentifier] else { return }

        task.complete(error: error)
    }
}

extension TwitterAPISessionDelegate: TwitterAPISessionDelegatedJSONTaskDelegate {
    func didFinishQueueInJsonTask(task: TwitterAPISessionDelegatedJSONTask) {
        tasks[task.taskIdentifier] = nil
    }
}
