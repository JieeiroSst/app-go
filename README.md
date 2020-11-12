<h1>How to write & run database migration in Golang</h1>

<h2>Install golang-migrate</h2>

<title>brew install golang-migrate</title>

<p>cd ~/Projects/test</p>
<p>mkdir simple_bank</p>
<p>cd test</p>
<p>mkdir -p db/migration</p>

<p> migrate create -ext sql -dir db/migration -seq init_schema</p>

<p> migrate -path db/migration -database "postgresql://root:1234@localhost:5432/postgres?sslmode=disable" -verbose up</p>

<h3>frameword golang fiber</h3>

<h4>install go get github.com/gofiber/fiber/v2</h4>

<h2> session</h2>

<p>store.ID() // returns session id</p>
<p>store.Destroy() // delete storage + cookie</p>
<p>store.Get("john") // get from storage</p>
<p>store.Regenerate() // generate new session id</p>
<p>store.Delete("john") // delete from storage</p>
<p>store.Set("john", "doe") // save to storage</p>

<h2>New app</h2>
<p>func New(config ...Config) \*App</p>
<br>
<p>// Default config</p>
<p>app := fiber.New()</p>

<p> NewError</p>
<p>  func NewError(code int, message ...string) \*Error</p>

<p> example:</p>
<p>  app.Get(func(c \*fiber.Ctx) error {</p>
<p>  return fiber.NewError(782, "Custom error message")</p>
<p>  })</p> 

<p> IsChild</p>

<p> func IsChild() bool</p>

<p>// Prefork will spawn child processes</p>
<p>if !fiber.IsChild() {</p>
<p>fmt.Println("I'm the parent process")</p>
<p>} else {</p>
<p>fmt.Println("I'm a child process")</p>
<p>}</p>

<h3>- Route Handlers</h3>
<p>  func (app *App) Get(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Head(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Post(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Put(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Delete(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Connect(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Options(path string, handlers ...Handler) Router</p>
<p>  func (app *App) Trace(path string, handlers ...Handler) Router</p>
<p>  func (app \*App) Patch(path string, handlers ...Handler) Router</p>

<p>// Add allows you to specifiy a method as value</p>
<p>func (app \*App) Add(method, path string, handlers ...Handler) Router</p>

<p>// All will register the route on all HTTP methods</p>
<p>// Almost the same as app.Use but not bound to prefixes</p>
<p>func (app \*App) All(path string, handlers ...Handler) Router</p>

<p>- example</p>
<p>  // Simple GET handler</p>
<p>  app.Get("/api/list", func(c \*fiber.Ctx)error{</p>
<p>  return c.SendString("I'm a GET request!")</p>
<p>  })</p>

<p>// Simple POST handler</p>
<p>app.Post("/api/register", func(c \*fiber.Ctx) error {</p>
<p>return c.SendString("I'm a POST request!")</p>
<p>})

<p>Use can be used for middleware packages and prefix catchers. These routes will only match the beginning of each path i.e. /john will match /john/doe, /johnnnnn etc</p>
<p>func (app *App) Use(args ...interface{}) Router</p>
<p>// Match any request</p>
<p>app.Use(func(c *fiber.Ctx) error {</p>
<p>return c.Next()</p>
<p>})</p>

<p>// Match request starting with /api</p>
<p>app.Use("/api", func(c \*fiber.Ctx) error {</p>
<p>return c.Next()</p>
<p>})</p>

<p>// Attach multiple handlers</p>
<p>app.Use("/api",func(c *fiber.Ctx) error {</p>
<p>c.Set("X-Custom-Header", random.String(32))</p>
<p>return c.Next()</p>
<p>}, func(c *fiber.Ctx) error {</p>
<p>return c.Next()</p>
<p>})

<h3>Mount</h3>

<p>You can Mount Fiber instance by creating a \*Mount</p>

<p>func (a *App) Mount(prefix string, app *App) Router</p>

<p>micro := fiber.New()</p>
<p>micro.Get("/doe", func(c \*fiber.Ctx) error {</p>
<p>return c.SendStatus(fiber.StatusOK)</p>
<p>})</p>

<p>app := fiber.New()</p>
<p>app.Mount("/john", micro) // GET /john/doe -> 200 OK</p>
<p>app.Listen(":3000")</p>

<h3>Group</h3>
<p>You can group routes by creating a \*Group struct.</p>

<p>func (app \*App) Group(prefix string, handlers ...Handler) Router</p>

<p>func main() {</p>
<p>app := fiber.New()</p>

<p>api := app.Group("/api", handler) // /api</p>

<p>v1 := api.Group("/v1", handler) // /api/v1</p>
<p>v1.Get("/list", handler) // /api/v1/list</p>
<p>v1.Get("/user", handler) // /api/v1/user</p>

<p>v2 := api.Group("/v2", handler) // /api/v2</p>
<p>v2.Get("/list", handler) // /api/v2/list</p>
<p>v2.Get("/user", handler) // /api/v2/user</p>

<p>app.Listen(3000)</p>
<p>}</p>

<p>// Create route with GET method for test:</p>
<p>app.Get("/", func(c \*fiber.Ctx) error {</p>
<p>fmt.Println(c.BaseURL()) // => http://google.com</p>
<p>fmt.Println(c.Get("X-Custom-Header")) // => hi</p>

<p>return c.SendString("hello, World!")</p>
<p>})</p>

<p>// http.Request</p>
<p>req := httptest.NewRequest("GET", "http://google.com", nil)</p>
<p>req.Header.Set("X-Custom-Header", "hi")</p>

<p>// http.Response</p>
<p>resp, \_ := app.Test(req)</p>

<p>// Do something with results:</p>
<p>if resp.StatusCode == 200 {</p>
<p>body, \_ := ioutil.ReadAll(resp.Body)</p>
<p>fmt.Println(string(body)) // => Hello, World!</p>
<p>}</p>
