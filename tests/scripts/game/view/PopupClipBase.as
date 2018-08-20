package game.view
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetDisposingWatcher;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.common.PopupTitle;
   
   public class PopupClipBase extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var button_close:ClipButton;
      
      public var bg:ClipSprite;
      
      public function PopupClipBase()
      {
         super();
         AssetDisposingWatcher.watch(this,getQualifiedClassName(this));
      }
      
      public function set title(param1:String) : void
      {
         PopupTitle.create(param1,header_layout_container);
      }
      
      override public function setNode(param1:Node) : void
      {
         if(dialog_frame && dialog_frame.graphics)
         {
            dialog_frame.graphics.touchable = false;
         }
      }
   }
}
