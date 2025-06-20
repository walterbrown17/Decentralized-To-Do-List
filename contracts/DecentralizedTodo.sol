// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DecentralizedTodo {
    struct Task {
        uint256 id;
        string content;
        bool completed;
    }

    uint256 private taskCounter;
    mapping(address => Task[]) private userTasks;

    event TaskCreated(address indexed user, uint256 taskId, string content);
    event TaskCompleted(address indexed user, uint256 taskId);
    event TaskDeleted(address indexed user, uint256 taskId);

    // Create a new task
    function createTask(string calldata _content) external {
        Task memory newTask = Task({
            id: taskCounter,
            content: _content,
            completed: false
        });
        userTasks[msg.sender].push(newTask);
        emit TaskCreated(msg.sender, taskCounter, _content);
        taskCounter++;
    }

    // Get all tasks for the sender
    function getMyTasks() external view returns (Task[] memory) {
        return userTasks[msg.sender];
    }

    // Mark a task as completed
    function completeTask(uint256 _taskId) external {
        Task[] storage tasks = userTasks[msg.sender];
        for (uint256 i = 0; i < tasks.length; i++) {
            if (tasks[i].id == _taskId && !tasks[i].completed) {
                tasks[i].completed = true;
                emit TaskCompleted(msg.sender, _taskId);
                return;
            }
        }
        revert("Task not found or already completed.");
    }

    // Delete a task
    function deleteTask(uint256 _taskId) external {
        Task[] storage tasks = userTasks[msg.sender];
        for (uint256 i = 0; i < tasks.length; i++) {
            if (tasks[i].id == _taskId) {
                tasks[i] = tasks[tasks.length - 1];
                tasks.pop();
                emit TaskDeleted(msg.sender, _taskId);
                return;
            }
        }
        revert("Task not found.");
    }
}
