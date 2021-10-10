import './App.css';
import Header from './Header';

function App() {
  const sections = document.querySelectorAll("section");
  const navLi = document.querySelectorAll("nav .container ul li");

  window.addEventListener("scroll", () => {
    let current = "";
    const howScrolled = window.pageYOffset
    sections.forEach((section) => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.clientHeight;
      if (howScrolled >= (sectionTop -sectionHeight / 3)) {
        current = section.getAttribute("id");
      }
    });
      navLi.forEach((li) => {
        li.classList.remove("active");
        if (li.classList.contains(current)) {
          li.classList.add("active");
        }
      });
  });

  return (
    <div className="">
      <Header />
      <section id="home">
        <h1>Home</h1>
      </section>
      <section id="about">
        <h1>About</h1>
      </section>
      <section id="contact">
        <h1>Contact</h1>
      </section>
      <section id="footer">
        <h1>Footer</h1>
      </section>


    </div>
  );
}

export default App;
