package game.battle.gui.block
{
   import game.assets.storage.AssetStorage;
   import game.battle.gui.BattleGuiReplayUsersClip;
   import game.battle.gui.BattleGuiViewBase;
   import game.model.user.UserInfo;
   
   public class BattleGuiUsersBlock extends BattleGuiBlock
   {
       
      
      private var clip:BattleGuiReplayUsersClip;
      
      public function BattleGuiUsersBlock()
      {
         clip = new BattleGuiReplayUsersClip();
         super();
      }
      
      override protected function subscribe(param1:BattleGuiViewBase) : void
      {
         param1.userAttacker.onValue(handler_userAttacker);
         param1.userDefeneder.onValue(handler_userDefender);
         param1.timeLeft.onValue(handler_timeLeft);
         AssetStorage.rsx.battle_interface.init_block_replay_users(clip);
         param1.addAnchoredObject(clip.graphics,10,NaN,NaN,NaN,-10);
         param1.hidePauseClock();
      }
      
      override protected function unsubscribe(param1:BattleGuiViewBase) : void
      {
         param1.userAttacker.unsubscribe(handler_userAttacker);
         param1.userDefeneder.unsubscribe(handler_userDefender);
         param1.timeLeft.unsubscribe(handler_timeLeft);
         clip.graphics.removeFromParent(true);
      }
      
      private function handler_userAttacker(param1:UserInfo) : void
      {
         clip.attacker.setUser(param1);
      }
      
      private function handler_userDefender(param1:UserInfo) : void
      {
         clip.defender.setUser(param1);
      }
      
      private function handler_timeLeft(param1:int) : void
      {
         var _loc3_:int = param1 / 60;
         var _loc2_:int = param1 % 60;
         clip.tf_timer.text = (_loc3_ != 0?String(_loc3_):"0") + ":" + (_loc2_ >= 10?String(_loc2_):"0" + _loc2_);
      }
   }
}
