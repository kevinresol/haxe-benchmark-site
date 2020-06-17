package data;

import api.Root;
import tink.url.Host;
import tink.web.proxy.Remote;
import tink.http.clients.SecureJsClient;

class BenchmarkData implements Model {
	@:constant var name:String;
	@:editable var version:HaxeVersion;
	@:constant var remote:Remote<Root> = new Remote<Root>(new SecureJsClient(), {host: new Host('benchs.haxe.org', 443), pathSuffix: '.json'});
	@:loaded var data:List<Data> = remote.get(name, version);
}
