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

		book.description = "na";
		book.isbn = "aaa";

		return book;
	}


}
