package comp
{
	import flash.events.Event;
	
	public class ComboCheckEvent extends Event
	{
		public var obj:Object;
		
		public function ComboCheckEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}