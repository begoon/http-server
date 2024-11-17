program HTTPServer;

{$mode objfpc}

uses
  fpjson, httpdefs, fphttpapp, httproute;

type
  TVersionInfo = record
    Version: string;
  end;

function VersionInfoToJSON(const Info: TVersionInfo): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('version', Info.Version);
end;

procedure VersionHandler(ARequest: TRequest; AResponse: TResponse);
var
  VersionInfo: TVersionInfo;
  ResponseJSON: TJSONObject;
begin
  VersionInfo.Version := '1.0.0';

  ResponseJSON := VersionInfoToJSON(VersionInfo);
  try
    AResponse.ContentType := 'application/json';
    AResponse.Content := ResponseJSON.AsJSON;
    AResponse.Code := 200;
  finally
    ResponseJSON.Free;
  end;
end;

procedure NotFoundHandler(ARequest: TRequest; AResponse: TResponse);
begin
  AResponse.Code := 404;
  AResponse.Content := '404 Not Found';
end;

begin
  HTTPRouter.RegisterRoute('/version', @VersionHandler);
  HTTPRouter.RegisterRoute('/*', @NotFoundHandler);

  Application.Port := 8000;
  WriteLn('listening on http://localhost:8080');
  Application.Run;
end.
