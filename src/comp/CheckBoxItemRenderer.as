package comp
{
	import flash.events.Event;  
	
	import mx.controls.Alert;  
	import mx.controls.CheckBox;  
	import mx.controls.listClasses.ListBase;  
	import mx.utils.ArrayUtil;  
	
	public class CheckBoxItemRenderer extends CheckBox{  
		
		/**存储当前列数据对象**/  
		private var currData:Object;   
		
		public function CheckBoxItemRenderer(){  
			super();  
			this.addEventListener(Event.CHANGE,onClickCheckBox);  
		}  
		
		override public function set data(value:Object):void{  
			this.selected = value.selected;  
			this.currData = value;   
			this.label=value.labelName;  
		}  
		
		override public function set enabled(value:Boolean):void{  
			
			if(currData){  
				value=currData.enabled==false?false:true;  
			}  
			super.enabled=value;  
		}  
		
		private function onClickCheckBox(e:Event):void{   
			var listBase:ListBase = ListBase(listData.owner);  
			var selectedItems:Array = listBase.selectedItems;  
			currData.selected = this.selected;  
			
			if(this.selected == true){  
				selectedItems.push(currData);  
			}else{  
				selectedItems.splice(ArrayUtil.getItemIndex(currData,selectedItems),1);  
			}  
			
			listBase.selectedItems=selectedItems;  
		}  
	}  
}