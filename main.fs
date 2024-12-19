open Suave
open Suave.Operators
open Suave.Filters
open Suave.Successful
open Suave.RequestErrors
open System.Text.Json

type Version = { version: string }

let app =
    choose [
        path "/version" >=> 
            fun _ ->
                let version = { version = "1.0.0" }
                let jsonResponse = JsonSerializer.Serialize(version)
                OK jsonResponse >=> Writers.setMimeType "application/json"
        NOT_FOUND "Not Found"
    ]

[<EntryPoint>]
let main argv =
    startWebServer defaultConfig app
    0
