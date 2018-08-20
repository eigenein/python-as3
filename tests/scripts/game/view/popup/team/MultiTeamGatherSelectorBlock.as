package game.view.popup.team
{
   import com.progrestar.common.lang.Translate;
   import game.mechanics.grand.popup.GrandSelectorButton;
   import game.mediator.gui.popup.team.MultiTeamGatherPopupMediator;
   
   public class MultiTeamGatherSelectorBlock
   {
       
      
      private var mediator:MultiTeamGatherPopupMediator;
      
      private var clip:GrandTeamSelectorClip;
      
      public function MultiTeamGatherSelectorBlock(param1:MultiTeamGatherPopupMediator, param2:GrandTeamSelectorClip)
      {
         super();
         if(!param2)
         {
            return;
         }
         this.mediator = param1;
         this.clip = param2;
         param1.signal_teamUpdate.add(handler_teamUpdate);
         param1.selectedTeam.onValue(handler_selectTeam);
         param2.button_team1.tf_label.text = Translate.translateArgs("UI_DIALOG_GRAND_ARENA_SELECTOR_TEAM","");
         param2.button_team2.tf_label.text = Translate.translateArgs("UI_DIALOG_GRAND_ARENA_SELECTOR_TEAM","");
         param2.button_team3.tf_label.text = Translate.translateArgs("UI_DIALOG_GRAND_ARENA_SELECTOR_TEAM","");
         param2.button_team1.block_number.text = "1";
         param2.button_team2.block_number.text = "2";
         param2.button_team3.block_number.text = "3";
         param2.button_team1.tf_count.text = getSelectorButtonText(0);
         param2.button_team2.tf_count.text = getSelectorButtonText(1);
         param2.button_team3.tf_count.text = getSelectorButtonText(2);
         param2.button_team1.signal_click.add(handler_teamSelected);
         param2.button_team2.signal_click.add(handler_teamSelected);
         param2.button_team3.signal_click.add(handler_teamSelected);
         param2.signal_changeButtonIndices.add(handler_changeButtonIndices);
      }
      
      public function dispose() : void
      {
         mediator.signal_teamUpdate.remove(handler_teamUpdate);
         mediator.selectedTeam.unsubscribe(handler_selectTeam);
         clip.signal_changeButtonIndices.remove(handler_changeButtonIndices);
      }
      
      private function getSelectorButtonText(param1:int) : String
      {
         return mediator.getTeamSize(param1) + " / " + mediator.maxTeamLength;
      }
      
      private function animateButtonText(param1:int, param2:int) : void
      {
         var _loc3_:GrandSelectorButton = clip.getButtonByIndex(param1);
         var _loc5_:String = getSelectorButtonText(param2);
         var _loc4_:String = _loc3_.tf_count.text;
         if(_loc4_ != _loc5_)
         {
            _loc3_.tf_count.text = _loc5_;
            if(_loc4_)
            {
               _loc3_.animate();
            }
         }
      }
      
      protected function handler_selectTeam(param1:int) : void
      {
         clip.selectedTeamIndex = param1;
      }
      
      protected function handler_teamUpdate() : void
      {
         animateButtonText(0,0);
         animateButtonText(1,1);
         animateButtonText(2,2);
      }
      
      private function handler_teamSelected(param1:int) : void
      {
         mediator.action_selectTeam(param1);
      }
      
      private function handler_changeButtonIndices(param1:int, param2:int) : void
      {
         mediator.action_changeTeamIndices(param1,param2);
      }
   }
}
