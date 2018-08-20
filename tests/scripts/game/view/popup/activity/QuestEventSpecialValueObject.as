package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestSpecialDescription;
   import game.model.user.Player;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestEventEntry;
   
   public class QuestEventSpecialValueObject extends QuestEventValueObjectBase
   {
       
      
      private var event:PlayerQuestEventEntry;
      
      public function QuestEventSpecialValueObject(param1:Player, param2:PlayerQuestEventEntry)
      {
         super(param1);
         this.event = param2;
         param1.questData.signal_questAdded.add(handler_update);
         param1.questData.signal_questRemoved.add(handler_update);
         param1.questData.signal_questProgress.add(handler_update);
         _canFarm.value = param1.questData.getEventCanFarm(param2);
      }
      
      override public function dispose() : void
      {
         player.questData.signal_questAdded.remove(handler_update);
         player.questData.signal_questRemoved.remove(handler_update);
         player.questData.signal_questProgress.remove(handler_update);
      }
      
      override public function get hasEndTime() : Boolean
      {
         return event.endTime > 0;
      }
      
      override public function get endTime() : Number
      {
         return event.endTime;
      }
      
      override public function get name() : String
      {
         return Translate.translate(event.name_localeKey);
      }
      
      override public function get desc() : String
      {
         return Translate.translate(event.desc_localeKey);
      }
      
      override public function get iconAsset() : String
      {
         return event.icon;
      }
      
      override public function get backgroundAsset() : String
      {
         return event.background;
      }
      
      override public function get sortOrder() : int
      {
         return event.sortOrder;
      }
      
      public function get eventId() : int
      {
         return event.id;
      }
      
      private function handler_update(param1:PlayerQuestEntry) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:QuestSpecialDescription = param1.desc as QuestSpecialDescription;
         if(_loc2_ == null)
         {
            return;
         }
         if(DataStorage.specialQuestEvent.getChainById(_loc2_.eventChainId).eventId == event.id)
         {
            _canFarm.value = player.questData.getEventCanFarm(event);
         }
      }
   }
}
