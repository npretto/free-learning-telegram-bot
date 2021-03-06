package;
import sys.db.Object;
import sys.db.Types.SId;
import sys.db.Types.SSmallText;
import sys.db.Types.SString;

/**
 * ...
 * @author 
 */
class Book extends Object
{
	public var id:SId;
	public var imagesrc:Null<SSmallText>;
	public var description:Null<SSmallText>;
	public var title:Null<SSmallText>;
	public var isbn:Null<SSmallText>;
	
	@:skip
	public var fileName:Null<String>;
	@:skip
	public var bookLink:String;
	
	public function new() 
	{
		super();
		
	}
	
	public override function toString()
	{
		return 'book#$id, "$title", isbn: $isbn, link: $bookLink';
	}
}