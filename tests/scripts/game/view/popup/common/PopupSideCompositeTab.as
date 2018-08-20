package game.view.popup.common
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import flash.errors.IllegalOperationError;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.gui.components.toggle.ToggleGroup;
   import idv.cjcat.signals.Signal;
   import starling.display.Sprite;
   
   public class PopupSideCompositeTab extends ClipToggleButton
   {
       
      
      public var NewIcon_inst0:ClipSprite;
      
      public var tf_label_selected:ClipLabel;
      
      public var tf_label_up:ClipLabel;
      
      public var bg_selected:GuiClipScale3Image;
      
      public var bg_up:GuiClipScale3Image;
      
      public var layout:ClipLayout;
      
      public var layout_sub_tabs:ClipLayout;
      
      public var buttonContainer:Sprite;
      
      private var toggle:ToggleGroup;
      
      private var _label:String;
      
      private var _subTabs:Array;
      
      private var _signal_subTabChange:Signal;
      
      public function PopupSideCompositeTab()
      {
         tf_label_selected = new ClipLabel();
         tf_label_up = new ClipLabel();
         layout = ClipLayout.horizontalMiddleCentered(0,tf_label_selected,tf_label_up);
         layout_sub_tabs = ClipLayout.vertical(-16);
         buttonContainer = new Sprite();
         toggle = new ToggleGroup();
         _signal_subTabChange = new Signal();
         super();
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function set label(param1:String) : void
      {
         if(_label == param1)
         {
            return;
         }
         _label = param1;
         var _loc2_:* = param1;
         tf_label_selected.text = _loc2_;
         tf_label_up.text = _loc2_;
         tf_label_up.adjustSizeToFitWidth();
         tf_label_selected.adjustSizeToFitWidth();
         tf_label_up.height = NaN;
         tf_label_selected.height = NaN;
      }
      
      public function set subTabs(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(!param1 || _subTabs == param1)
         {
            return;
         }
         _subTabs = param1;
         layout_sub_tabs.removeChildren();
         layout_sub_tabs.height = NaN;
         _loc2_ = 0;
         while(_loc2_ < _subTabs.length)
         {
            _loc3_ = createSubTabButton(_subTabs[_loc2_]);
            toggle.addItem(_loc3_);
            layout_sub_tabs.addChild(_loc3_.graphics);
            _loc2_++;
         }
         layout_sub_tabs.validate();
      }
      
      public function get selectedItem() : *
      {
         if(_subTabs && _subTabs.length >= toggle.selectedIndex)
         {
            return _subTabs[toggle.selectedIndex];
         }
         return null;
      }
      
      public function get signal_subTabChange() : Signal
      {
         return _signal_subTabChange;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(isSelected == param1)
         {
            return;
         }
         .super.isSelected = param1;
         if(param1)
         {
            signal_subTabChange.dispatch();
         }
      }
      
      public function set selectedIndex(param1:uint) : void
      {
         toggle.selectedIndex = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         buttonContainer.addChild(bg_selected.graphics);
         buttonContainer.addChild(bg_up.graphics);
         buttonContainer.addChild(layout);
         container.addChild(buttonContainer);
         if(NewIcon_inst0)
         {
            NewIcon_inst0.graphics.touchable = false;
         }
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
      }
      
      override protected function updateViewState() : void
      {
         super.updateViewState();
         var _loc1_:* = _isSelected;
         bg_selected.graphics.visible = _loc1_;
         tf_label_selected.visible = _loc1_;
         _loc1_ = !_isSelected;
         bg_up.graphics.visible = _loc1_;
         tf_label_up.visible = _loc1_;
         if(_isSelected)
         {
            container.addChild(layout_sub_tabs);
         }
         else
         {
            layout_sub_tabs.removeFromParent();
         }
      }
      
      protected function createSubTabButton(param1:*) : PopupSideTab
      {
         throw new IllegalOperationError("Must override Concreate Class");
      }
      
      private function handler_tabSelected() : void
      {
         if(isSelected)
         {
            signal_subTabChange.dispatch();
         }
      }
   }
}
