package game.mediator.gui.popup.titan.evolve
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.shop.ShopCostPanel;
   
   public class TitanEvolveCostPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_hero_name:ClipLabel;
      
      public var tf_label_header:ClipLabel;
      
      public var cost_panel:ShopCostPanel;
      
      public var hero_portrait:GuiClipContainer;
      
      public var sun:ClipSprite;
      
      public var bg:GuiClipScale9Image;
      
      public var bg2:GuiClipScale9Image;
      
      public function TitanEvolveCostPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         tf_hero_name = new ClipLabel();
         tf_label_header = new ClipLabel();
         cost_panel = new ShopCostPanel();
         hero_portrait = new GuiClipContainer();
         sun = new ClipSprite();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         bg2 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
