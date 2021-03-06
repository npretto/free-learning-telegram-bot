package;
import haxe.Http;
import haxe.io.BytesOutput;
import haxe.io.StringInput;
import sys.io.File;

/**
 * ...
 * @author
 */
class TelegramBot
{
	public var token:String;
	public function new()
	{

	}

	public function sendMessage(id:String, message:String)
	{
		var req = new Http('https://api.telegram.org/bot$token/sendMessage');

		req.addParameter("chat_id", id);
		req.addParameter("parse_mode", "Markdown");
		req.addParameter("text",message);

		req.onStatus = function(status:Int){
			trace('status: $status');
			trace(req.responseHeaders);
			trace(req.responseData);
		}
		req.onError = function(msg:String)
		{
			trace("ERROR:" + msg);
		}
		req.cnxTimeout = 120;
		req.request();
		trace(req.responseData);
	}

	public function sendPhoto(id:String,image:String,?message:String)
	{
		var req = new Http('https://api.telegram.org/bot$token/sendPhoto');

		req.addParameter("chat_id", id);
		req.addParameter("parse_mode", "Markdown");
			if (!(message == "" || message == null))
		{
			req.addParameter("caption",message);
		}

		var bla:StringInput = new StringInput(image);
		//trace(image);
		//trace(bla.length);
		req.fileTransfer("photo", "d2s2s2s.jpg", bla, bla.length);
		req.onStatus = function(status:Int){
			trace('status: $status');
			trace(req.responseHeaders);
			trace(req.responseData);
		}
		req.onError = function(msg:String)
		{
			trace("ERROR:" + msg);
		}
		req.cnxTimeout = 180;
		req.noShutdown = true;
		var out = new BytesOutput();
		// req.customRequest(true,new BytesOutput() );
		req.request(true);
		trace(req.responseData);
	}

	public function loadTokenFromFile(path:String)
	{
		token = File.read(path).readAll().toString();
	}

}
