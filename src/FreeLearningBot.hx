package;
import haxe.Http;
import sys.db.Manager;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.io.File;

using StringTools;

/**
 * ...
 * @author 
 */
class FreeLearningBot
{
	var cnx:sys.db.Connection;
	var page:String;

	public function new() 
	{
		setupDB();
		
		downloadPage();
		//useCachedPage();
		
		cachePage();
		trace("\nparsing the page");
		var book = PacktPubTools.parseFreeLearningPage(page);
		trace(book.imagesrc);
		//downloadImage(book.imagesrc);
		if (true)//book.title != Book.manager.get(Book.manager.count()).title)
		{
			trace("\n\n\n\n");
			trace(book);
			trace("\n\n\n\n");

			book.insert();
			var telegramBot = new TelegramBot();
			telegramBot.loadTokenFromFile('.token');
			var message = "New book available for free!\n";
			message += '*${book.title}*\n\n';
			message += '${book.description}\n';
			message += '*Get it for free now:* http://bit.ly/free-learning-bot \n';
			message += '*Check the reviews on your local amazon:* http://buuy.me/isbn/${book.isbn} \n';
			
			
			
			saveBookOnDisk(book, message);

			
			telegramBot.sendPhoto("@freelearningbooks", "cache.jpg");
			telegramBot.sendMessage("@freelearningbooks", message);
		}
		closeDB();
	}
	
	function useCachedPage() 
	{
		page = File.read("cache.html").readAll().toString();
	}
	
	function downloadImage(path:String) 
	{
		trace('\ndownloading the image from $path');
		File.write("cache.jpg").writeString(Http.requestUrl(path));
	}
	
	function cachePage() 
	{
		trace("\nsaving the page to cache.html...");
		File.write("cache.html").writeString(page);
	}
	
	function downloadPage() 
	{
		trace("downloading the page...");
		page = PacktPubTools.getFreeLearningPage();
	}
	
	function closeDB() 
	{
		// close the connection and do some cleanup
		sys.db.Manager.cleanup();

		// Close the connection
		cnx.close();
	}
	
	function setupDB() 
	{
		cnx = Sqlite.open("my-database.sqlite");

		// Set as the connection for our SPOD manager
		Manager.cnx = cnx;

		// initialize manager
		Manager.initialize();

		// Create the "user" table
		if ( !TableCreate.exists(Book.manager) ) {
			TableCreate.create(Book.manager);
		}
	}
	
	private function saveBookOnDisk(book:Book, message:String) 
	{
		var date = DateTools.format(Date.now(), "%Y-%m-%d-%M");
		trace(date);
		try{
			File.saveContent('books/$date.md',message);
		}catch (e:Dynamic)
		{
			trace(e);
		}
		book.fileName = "$date";
	}
	
}