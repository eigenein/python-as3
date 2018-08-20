package game.view.popup.hero.skins
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.refillable.CostButton;
   
   public class SkinListItemClip extends GuiClipNestedContainer
   {
       
      
      public var action_button:CostButton;
      
      public var btn_unlock:ClipButtonLabeled;
      
      public var action_tf:ClipLabel;
      
      public var stat_tf:SpecialClipLabel;
      
      public var level_tf:SpecialClipLabel;
      
      public var title_tf:SpecialClipLabel;
      
      public var btn_event:ClipButtonLabeled;
      
      public var event_tf:ClipLabel;
      
      public var border:ClipSprite;
      
      public var check_bg:ClipSprite;
      
      public var check_icon:ClipSprite;
      
      public var image_item:ClipSprite;
      
      public var line2:ClipSprite;
      
      public var lock_icon:ClipSprite;
      
      public var browes_icon:ClipSprite;
      
      public var stars_container:ClipSprite;
      
      public var animation:GuiAnimation;
      
      public var bg:ClipButton;
      
      public var bg_selected:GuiClipScale9Image;
      
      public var description_layout:ClipLayout;
      
      public function SkinListItemClip()
      {
         action_button = new CostButton();
         btn_unlock = new ClipButtonLabeled();
         action_tf = new ClipLabel();
         stat_tf = new SpecialClipLabel();
         level_tf = new SpecialClipLabel();
         title_tf = new SpecialClipLabel();
         btn_event = new ClipButtonLabeled();
         event_tf = new ClipLabel();
         border = new ClipSprite();
         check_bg = new ClipSprite();
         check_icon = new ClipSprite();
         image_item = new ClipSprite();
         line2 = new ClipSprite();
         lock_icon = new ClipSprite();
         browes_icon = new ClipSprite();
         stars_container = new ClipSprite();
         animation = new GuiAnimation();
         bg = new ClipButton();
         bg_selected = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         description_layout = ClipLayout.verticalMiddleCenter(8,stat_tf,level_tf);
         super();
      }
      
      public function dispose() : void
      {
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
