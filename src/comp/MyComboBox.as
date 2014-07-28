package comp
{
	import flash.events.Event;  
	import flash.events.MouseEvent;  
	import mx.controls.Alert;  
	import mx.controls.ComboBox;  
	import mx.core.ClassFactory;  
	import mx.events.FlexEvent;  
	import mx.events.ListEvent;  
	
	public class MyComboBox extends ComboBox{  
		
		private var mouseOut:Boolean=true;  
		
		[Bindable]  
		private var promptText:String="";  
		
		public function MyComboBox(){  
			super();  
			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreateCompleteHandle);  
			this.itemRenderer=new ClassFactory(CheckBoxItemRenderer);  
		}  
		
		private function onCreateCompleteHandle(event:FlexEvent):void{  
			dropdown.allowMultipleSelection=true;  
			close();  
		}  
		
		private function initListener():void{  
			if(!dropdown.hasEventListener(MouseEvent.ROLL_OVER))  {
				dropdown.addEventListener(MouseEvent.ROLL_OVER,onRollOverHandle);  
			}
			if(!dropdown.hasEventListener(MouseEvent.ROLL_OUT))  {
				dropdown.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandle);  
			}
		}  
		
		private function onRollOverHandle(event:MouseEvent):void{  
			mouseOut=false;  
		}  
		
		private var changeEvent:ListEvent;  
		
		private function onRollOutHandle(event:MouseEvent):void{  
			mouseOut=true;  
			var selectedStr:String = "";  
			
			if(selectedItems.length>0){  
				//赋值  
				for each(var item:Object in selectedItems){  
					if(item.selected == true){  
						selectedStr += item.labelName+"/";  
					}  
				}  
				this.promptText = selectedStr.substring(0,selectedStr.length -1) ;  
				close();  
				changeEvent= new ListEvent( ListEvent.CHANGE )  
				dispatchEvent( changeEvent);  
			}  
		}  
		
		public function set selectedItems(value:Array):void{  
			
			if (dropdown)  
				dropdown.selectedItems=value;  
		}  
		
		[Bindable("change")]  
		public function get selectedItems():Array{  
			return dropdown?dropdown.selectedItems:[];  
		}  
		
		public function set selectedIndices(value:Array):void{  
			if (dropdown)  
				dropdown.selectedIndices=value;  
		}  
		
		[Bindable("change")]  
		public function get selectedIndices():Array{  
			return dropdown?dropdown.selectedIndices:[];  
		}  
		
		override public function close(trigger:Event=null):void{  
			initListener();  
			if (mouseOut){  
				super.close(trigger);  
			}  
			this.textInput.text=promptText;  
			this.toolTip = promptText;  
		}  
		
		override public function set prompt(value:String):void{  
			promptText=value;  
		}  
	}  
}