import Foundation

class TwitterAPISessionDelegate: NSObject, URLSessionDataDelegate {

    private var tasks = [Int /* taskIdentifier */: TwitterAPISessionDelegatedResponse]()

    func appendAndResume(task: URLSessionTask) -> TwitterAPISessionResponse {

        let twTask = TwitterAPISessionDelegatedResponse(task: task)
        tasks[task.taskIdentifier] = twTask

        task.resume()

        return twTask
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        tasks[dataTask.taskIdentifier]?.append(chunk: data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        tasks[task.taskIdentifier]?.complete(error: error)
        tasks.removeValue(forKey: task.taskIdentifier)
    }
}
