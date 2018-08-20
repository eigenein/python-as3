package game.view.popup.common
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.toggle.ClipToggleButton;
   
   public class PopupSideTab extends ClipToggleButton
   {
       
      
      public var NewIcon_inst0:ClipSprite;
      
      public var tf_label_selected:ClipLabel;
      
      public var tf_label_up:ClipLabel;
      
      public var bg_selected:GuiClipScale3Image;
      
      public var bg_up:GuiClipScale3Image;
      
      public var layout:ClipLayout;
      
      private var _label:String;
      
      public function PopupSideTab()
      {
         tf_label_selected = new ClipLabel();
         tf_label_up = new ClipLabel();
         layout = ClipLayout.horizontalMiddleCentered(0,tf_label_selected,tf_label_up);
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
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(NewIcon_inst0)
         {
            NewIcon_inst0.graphics.touchable = false;
         }
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
      }
   }
}
