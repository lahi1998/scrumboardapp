using Microsoft.AspNetCore.Mvc;

namespace ServerMkcert.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : Controller
    {
        [HttpGet]
        public IActionResult Index()
        {
            return Ok("Hello world");
        }
    }
}
