package;

import neko.Lib;
import sys.io.File;

/**
 * ...
 * @author 
 */
class Main 
{
	
	static function main() 
	{
		//download a cached version of the page
		//var cache:String = PacktPubTools.getFreeLearningPage();
		//File.write("cache.html").writeString(cache);

		
		var page = File.read("cache.html").readAll().toString();
		var image_path = "cache.jpg";
		//trace(page);
		//var book = PacktPubTools.parseFreeLearningPage(page);
		var book = PacktPubTools.parseFreeLearningPage(PacktPubTools.getFreeLearningPage());
		trace(book);
		
		var bot = new TelegramBot();
		bot.loadTokenFromFile('.token');
		
		//trace("\n\n\n\n");
		var message = "New book available for free!\n";
		message += '*${book.title}*\n\n';
		bot.sendMessage("@freelearningbooks", message);

		trace("\n\n\n");
		
		bot.sendPhoto("@freelearningbooks", image_path);
		trace("\n\n\n");

		message = '${book.description}\n';
		message += '*Get it for free now:* http://bit.ly/free-learning-bot \n';
		message += '*Check the reviews on your local amazon:* http://buuy.me/isbn/${book.isbn} \n';
		bot.sendMessage("@freelearningbooks", message);
	}
	
}