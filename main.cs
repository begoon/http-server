using System;
using System.Net;
using System.Text;
using Newtonsoft.Json;
using System.Collections.Generic;

class HttpServer
{
    static void Main()
    {
        var versionInfo = new Dictionary<string, string> { { "version", "1.0.0" } };

        HttpListener listener = new HttpListener();
        listener.Prefixes.Add("http://*:8000/");
        listener.Start();
        Console.WriteLine("listening on http://localhost:8080");

        while (true)
        {
            var context = listener.GetContext();
            var request = context.Request;
            var response = context.Response;

            if (request.HttpMethod == "GET" && request.Url.AbsolutePath == "/version")
            {
                response.ContentType = "application/json";
                response.StatusCode = (int)HttpStatusCode.OK;

                var json = JsonConvert.SerializeObject(versionInfo, Formatting.Indented);
                byte[] buffer = Encoding.UTF8.GetBytes(json);
                response.ContentLength64 = buffer.Length;
                response.OutputStream.Write(buffer, 0, buffer.Length);
            }
            else
            {
                response.StatusCode = (int)HttpStatusCode.NotFound;
                byte[] buffer = Encoding.UTF8.GetBytes("404 Not Found");
                response.ContentLength64 = buffer.Length;
                response.OutputStream.Write(buffer, 0, buffer.Length);
            }
            response.OutputStream.Close();
        }
    }
}
