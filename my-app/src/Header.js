import React from 'react'

function Header() {
    return (
        <nav>
            <div className="container">
                <ul>
                    <li className="home active"><a href="#home">Home</a></li>
                    <li className="about"><a href="#about">About</a></li>
                    <li className="contact"><a href="#contact">Contact</a></li>
                    <li className="footer"><a href="#footer">Footer</a></li>
                </ul>
            </div>
        </nav>
    )
}

export default Header
