package comp
{
	import spark.components.DropDownList;
	
	public class DropdownListEx extends DropDownList
	{
		public function DropdownListEx()
		{
			super();
			this.allowMultipleSelection = true;
		}
		
		override public function closeDropDown(commit:Boolean):void{
			//super.closeDropDown(commit);
		}
		
		override public function set selectedItems(value:Vector.<Object>):void{
			super.selectedItems = value;
		}
		
		override public function get selectedItems():Vector.<Object>{
			return super.selectedItems;
		}
		
		override public function get prompt():String{
			
			 var selectedItems2:Vector.<Object> = selectedItems;
			 
			 var ss:String = '';
			 
			 for each (var obj:Object in selectedItems2) 
			 {
				 ss += obj.toString() + ",";
			 }
			 
			return ss;
		}
		
		override public function set prompt(value:String):void{
			super.prompt = value;
		}
	}
}