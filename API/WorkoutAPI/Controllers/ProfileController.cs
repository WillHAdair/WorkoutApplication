using Microsoft.AspNetCore.Mvc;
using WorkoutAPI.Models;

namespace WorkoutAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProfileController
    {
        [HttpGet]
        public UserProfile GetProfile()
        {
            return TestData.TestData.profile;
        }

    }
}
