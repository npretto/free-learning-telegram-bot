package;
import haxe.Http;
import htmlparser.HtmlDocument;

using StringTools;

/**
 * ...
 * @author
 */
class PacktPubTools
{

	public static function getFreeLearningPage():String
	{
		return Http.requestUrl("https://www.packtpub.com/packt/offers/free-learning");
	}

	public static function parseFreeLearningPage(page:String):Book
	{
		var errors = new Array<String>();
		var book:Book = new Book();
		var html = new HtmlDocument(page);
		var titles = html.find(".dotd-title>h2");
		if (titles.length > 0)
		{
			book.title = titles[0].innerText.trim();
		}else
		{
			errors.push("book title not found");
		}

		var imagelink = html.find(".dotd-main-book-image>a>img");
		if (imagelink.length > 0)
		{
			book.imagesrc = imagelink[0].getAttribute('data-original');
			if (book.imagesrc.substr(0, 2) == "//")
			{
				book.imagesrc = "https:" + book.imagesrc;
			}
			book.imagesrc = book.imagesrc.replace(" ", "%20");
		}else
		{
			errors.push("book image title not found");
		}
		
		var bookLink = html.find(".dotd-main-book-image>a");
		if (bookLink.length > 0)
		{
			var bookLink = bookLink[0].getAttribute('href');
			if (bookLink.substr(0, 1) == "/")
			{
				bookLink = "https://www.packtpub.com" + bookLink;
			}
			book.bookLink = bookLink;
		}else
		{
			errors.push("book link title not found");
		}
		
		
		//var descriptionElement = html.find(".dotd-main-book-summary");
		//if (descriptionElement.length > 0)
		//{
			//
			//var description = "";
			//try
			//{
				//description += StringTools.trim(descriptionElement[0].children[3].innerText) + "\n";
			//}catch (e:Dynamic)
			//{
				//trace("could not find the description");
			//}
			//try
			//{
				//description += StringTools.trim(descriptionElement[0].children[4].innerText) + "\n";
			//}catch (e:Dynamic)
			//{
				//trace("could not find the description");
			//}
			//
			////trace("\n\n\n");
			//trace(description);
			////trace("\n\n\n");
			//
			////book.description = description;
		//}
		//
		
		return book;
	}
	
	static public function parseBookPage(book:Book) 
	{
		var page = Http.requestUrl(book.bookLink);
		var html = new HtmlDocument(page,true);
		//var descriptionElement = html.find(".book-info-bottom-indetail-text");
		//if (descriptionElement.length > 0)
		//{
			//var description = StringTools.trim(descriptionElement[0].innerText);
			//trace("\n\n\n");
			//trace(description);
			//trace("\n\n\n");
			//
			//book.description = description;
		//}
		
		var isbn = "";
		
		try {
			isbn = html.find(".book-info-isbn13")[0].children[1].innerText;
		}
		
		book.isbn = isbn;
	}


}
