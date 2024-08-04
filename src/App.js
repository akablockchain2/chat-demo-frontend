// App.js
import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [messages, setMessages] = useState([]);
  const [inputValue, setInputValue] = useState('');
  const [error, setError] = useState('');

  useEffect(() => {
    fetchMessages();
  }, []);

  const fetchMessages = async () => {
    try {
      const response = await fetch(`/chat`);
      if (!response.ok) throw new Error('Error fetching messages');
      const data = await response.json();
      setMessages(data);
    } catch (error) {
      setError('Failed to fetch messages');
    }
  };

  const addMessage = async () => {
    if (inputValue.trim() === '') return;

    try {
      const response = await fetch(`/chat`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: inputValue }),
      });
      if (!response.ok) throw new Error('Error adding message');
      setInputValue('');
      fetchMessages(); // обновить список сообщений после добавления нового
    } catch (error) {
      setError('Failed to add message');
    }
  };

  const handleInputChange = (e) => {
    setInputValue(e.target.value);
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      addMessage();
    }
  };

  return (
    <div className="App">
      <div className="messages">
        {messages.map((msg, index) => (
          <div key={index} className="message">
            <strong>{msg.ip}</strong> - {msg.datetime}: {msg.message}
          </div>
        ))}
      </div>
      <input
        type="text"
        value={inputValue}
        onChange={handleInputChange}
        onKeyPress={handleKeyPress}
        placeholder="Type your message"
        className="message-input"
      />
      {error && <div className="error">{error}</div>}
    </div>
  );
}

export default App;
