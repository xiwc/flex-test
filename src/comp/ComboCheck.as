package comp
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	import mx.core.ClassFactory;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	
	[Event(name="addItem", type="flash.events.Event")]
	[Event(name="itemsCreated", type="flash.events.Event")]
	
	public class ComboCheck extends ComboBox {
		private var _selectedItems:ArrayCollection;
		
		[Bindable("change")]
		[Bindable("valueCommit")]
		[Bindable("collectionChange")]
		public function set selectedItems1(value:ArrayCollection):void {
			_selectedItems=value;
		}
		
		public function get selectedItems1():ArrayCollection {
			return _selectedItems;
		}
		
		public function ComboCheck() {
			super();
			addEventListener("comboChecked", onComboChecked);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			addEventListener(Event.CLOSE, onDropDownInit);
			if(_selectedItems)trace("ComboCheck="+_selectedItems.length);
		}
		
		private function onCreationComplete(event:Event):void {
			dropdown.addEventListener(FlexEvent.CREATION_COMPLETE, onDropDownComplete);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			/*if(_selectedItems)trace("commitProperties="+_selectedItems.length);*/
			var render:ClassFactory = new ClassFactory(ComboCheckItemRenderer);
			super.itemRenderer=render;
			var myDropDownFactory:ClassFactory = new ClassFactory(ComboCheckDropDownFactory);
			super.dropdownFactory=myDropDownFactory;
			
			selectedItems1=new ArrayCollection();
			for each (var item:Object in dataProvider) {
				var index:int=selectedItems1.getItemIndex(item);
				if (item.assigned==true) {
					if (index==-1) {
						selectedItems1.addItem(item);
					}
				} else {
					if (index!=-1) {
						selectedItems1.removeItemAt(index);
					}
				}
			}
			
			setText()
			
			dispatchEvent(new Event("itemsCreated"));
			trace ("commit properties!");
		}
		
		private function onDropDownInit(event:Event):void {
			invalidateProperties();//commitProperties();
		} 
		
		private function onDropDownComplete(event:Event):void {
			trace ("dropdown complete!");
		} 
		
		private function onComboChecked(event:ComboCheckEvent):void {
			trace("onComboChecked");
			var obj:Object=event.obj;
			var index:int=selectedItems1.getItemIndex(obj);
			if (index==-1) {
				selectedItems1.addItem(obj);
			} else {
				selectedItems1.removeItemAt(index);
			}
			
			setText();
			
			dispatchEvent(new Event("valueCommit"));
			dispatchEvent(new Event("addItem"));
		}
		
		private function setText():void {
			if (selectedItems1.length>1) {
				textInput.text='multiple'
			}
			if (selectedItems1.length==1) {
				textInput.text=selectedItems1.getItemAt(0)[labelField];
			}
			if (selectedItems1.length<1) {
				textInput.text='';
			}
		}
	}
}