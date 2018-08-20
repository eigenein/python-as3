package game.mechanics.clan_war.popup.start
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.clan_war.popup.ClanWarScreenView_VSClip;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanWarStartScreenAttackBlockClip extends GuiClipNestedContainer
   {
       
      
      public var button_attack:ClipButtonLabeled;
      
      public var red_dot:ClipSprite;
      
      public var tf_state:ClipLabel;
      
      public var tf_tries:SpecialClipLabel;
      
      public var vs_header:ClanWarScreenView_VSClip;
      
      public function ClanWarStartScreenAttackBlockClip()
      {
         button_attack = new ClipButtonLabeled();
         red_dot = new ClipSprite();
         tf_state = new ClipLabel();
         tf_tries = new SpecialClipLabel();
         vs_header = new ClanWarScreenView_VSClip();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         red_dot.graphics.touchable = false;
      }
   }
}
