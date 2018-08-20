package game.view.popup.reward.multi
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaRewardValueObject;
   import game.mediator.gui.component.RewardValueObject;
   
   public class TitanArenaRewardRenderer extends MultiRewardRenderer
   {
       
      
      public function TitanArenaRewardRenderer()
      {
         super();
      }
      
      override protected function setCaption(param1:RewardValueObject) : void
      {
         if(!clip)
         {
            return;
         }
         var _loc2_:TitanArenaRewardValueObject = param1 as TitanArenaRewardValueObject;
         clip.tf_caption.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_MULTI_REWARD_TITLE",_loc2_.points);
         clip.layout_item_list.list.dataProvider = new ListCollection(_loc2_.reward.outputDisplay);
         clip.tf_empty.visible = false;
      }
   }
}
