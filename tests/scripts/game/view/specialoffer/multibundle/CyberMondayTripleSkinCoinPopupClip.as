package game.view.specialoffer.multibundle
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   
   public class CyberMondayTripleSkinCoinPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_label_timer:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var blindSideTop:ClipSprite;
      
      public var renderer:Vector.<CyberMondayTripleSkinItemClip>;
      
      public var header:ClipLayout;
      
      public var layout_timer:ClipLayout;
      
      public var layout_vip_header:ClipLayout;
      
      public var tf_label_skin_name:ClipLabel;
      
      public var layout_skin_name:ClipLayout;
      
      public var untouchable:ClipSpriteUntouchable;
      
      public function CyberMondayTripleSkinCoinPopupClip()
      {
         tf_header = new ClipLabel();
         tf_label_timer = new ClipLabel(true);
         tf_timer = new ClipLabel(true);
         button_close = new ClipButton();
         blindSideTop = new ClipSprite();
         renderer = new Vector.<CyberMondayTripleSkinItemClip>();
         header = new ClipLayoutNone();
         layout_timer = ClipLayout.horizontalMiddleCentered(4,tf_label_timer,tf_timer);
         layout_vip_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         tf_label_skin_name = new ClipLabel(true);
         layout_skin_name = ClipLayout.horizontalMiddleCentered(4,tf_label_skin_name);
         untouchable = new ClipSpriteUntouchable();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:GuiClipScale3Image = AssetStorage.rsx.chest_graphics.create(GuiClipScale3Image,"header_220_199_100");
         _loc2_.graphics.width = header.width;
         header.addChild(_loc2_.graphics);
      }
   }
}
