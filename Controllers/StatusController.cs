
using Microsoft.AspNetCore.Mvc;

namespace Test.Controllers
{
    public class StatusController : ControllerBase
    {
        public StatusController()
        {

        }
        [HttpGet("Status")]
        public async Task<IActionResult> Status()
        {
            return Ok("Am alive!");
        }
    }
}
