package game.view.popup.activity
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.dailybonus.DailyBonusPopupList;
   
   public class DailyBonusViewClip extends GuiClipNestedContainer
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var scroll_slider_container:GameScrollBar;
      
      public var list_container:DailyBonusPopupList;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public function DailyBonusViewClip()
      {
         tf_caption = new ClipLabel();
         scroll_slider_container = new GameScrollBar();
         list_container = new DailyBonusPopupList(scroll_slider_container);
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:Boolean = false;
         gradient_top.graphics.touchable = _loc2_;
         gradient_bottom.graphics.touchable = _loc2_;
      }
   }
}
