package game.battle.gui.block
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.battle.gui.BattleGuiViewBase;
   
   public class BattleGuiYourTeamTextBlock extends BattleGuiBlock
   {
       
      
      private var playerIsAttacker:Boolean;
      
      private var playerIsDefender:Boolean;
      
      private var clip:BattleGuiYourTeamTextBlockClip;
      
      public function BattleGuiYourTeamTextBlock(param1:Boolean, param2:Boolean)
      {
         super();
         this.playerIsAttacker = param1;
         this.playerIsDefender = param2;
      }
      
      override public function advanceTime(param1:Number, param2:Number) : void
      {
         clip.advanceTime(param2);
      }
      
      override protected function subscribe(param1:BattleGuiViewBase) : void
      {
         clip = AssetStorage.rsx.battle_interface.create_your_team_text_block();
         clip.playback.playOnceAndHide();
         clip.playback.signal_completed.add(handler_completed);
         clip.doPlayWithEnterFrame = false;
         if(playerIsAttacker)
         {
            clip.tf_text.text = Translate.translate("UI_BATTLE_YOUR_TEAM_SIDE_ATTACKERS");
            param1.addAnchoredObject(clip.graphics,95,NaN,NaN,0);
         }
         else if(playerIsDefender)
         {
            clip.tf_text.text = Translate.translate("UI_BATTLE_YOUR_TEAM_SIDE_DEFENDERS");
            param1.addAnchoredObject(clip.graphics,95,0,NaN,NaN);
         }
      }
      
      override protected function unsubscribe(param1:BattleGuiViewBase) : void
      {
         clip.graphics.removeFromParent(true);
      }
      
      private function handler_completed() : void
      {
         if(base)
         {
            base.removeBlock(this);
         }
      }
   }
}
