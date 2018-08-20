package game.mechanics.clan_war.popup.start
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanWarDefensePlanClip extends GuiClipNestedContainer
   {
       
      
      public var button_defense_plan:ClipButtonLabeled;
      
      public var red_dot:ClipSprite;
      
      public var guiClipLabel:ClipLabel;
      
      public var lock_icon:ClipSprite;
      
      public var lock_bg:GuiClipScale9Image;
      
      public var lock_layout:ClipLayout;
      
      public function ClanWarDefensePlanClip()
      {
         button_defense_plan = new ClipButtonLabeled();
         red_dot = new ClipSprite();
         guiClipLabel = new ClipLabel();
         lock_icon = new ClipSprite();
         lock_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         lock_layout = ClipLayout.horizontalMiddleCentered(4,lock_icon,guiClipLabel);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         red_dot.graphics.touchable = false;
      }
      
      public function setState_buttonVisible(param1:Boolean) : void
      {
         lock_layout.graphics.visible = !param1;
         lock_bg.graphics.visible = !param1;
         button_defense_plan.graphics.visible = param1;
      }
      
      public function setState_buttonEnabled(param1:Boolean) : void
      {
         button_defense_plan.isEnabled = param1;
         button_defense_plan.graphics.alpha = !!param1?1:0.2;
         AssetStorage.rsx.popup_theme.setDisabledFilter(button_defense_plan.graphics,!param1);
      }
      
      public function updateTimerText(param1:String) : void
      {
         guiClipLabel.text = param1;
      }
   }
}
