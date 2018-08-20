package game.view.popup.tower.screen
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class TowerScreenBattleDoorButton extends ClipButton
   {
       
      
      public var tf_to_battle:ClipLabel;
      
      public var anim_1:GuiAnimation;
      
      public var anim_2:GuiAnimation;
      
      public var state_over:GuiAnimation;
      
      public var state_up:GuiAnimation;
      
      public function TowerScreenBattleDoorButton()
      {
         tf_to_battle = new ClipLabel();
         anim_1 = new GuiAnimation();
         anim_2 = new GuiAnimation();
         state_over = new GuiAnimation();
         state_up = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         state_over.stop();
         state_over.graphics.visible = false;
         tf_to_battle.text = Translate.translate("UI_TOWER_BATTLE_BUTTON");
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         .super.isEnabled = param1;
         if(!param1)
         {
            state_over.graphics.visible = false;
            state_over.stop();
            state_up.stop();
            anim_2.stop();
         }
         else
         {
            anim_2.play();
            state_up.play();
         }
         tf_to_battle.visible = param1;
         state_up.graphics.visible = param1;
         anim_2.graphics.visible = param1;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            state_over.play();
            state_over.graphics.visible = true;
            state_up.stop();
            state_up.graphics.visible = false;
         }
         else
         {
            state_up.play();
            state_up.graphics.visible = true;
            state_over.stop();
            state_over.graphics.visible = false;
         }
      }
   }
}
