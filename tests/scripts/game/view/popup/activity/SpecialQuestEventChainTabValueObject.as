package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.quest.SpecialQuestEventChainElementDescription;
   
   public class SpecialQuestEventChainTabValueObject
   {
       
      
      protected var desc:SpecialQuestEventChainElementDescription;
      
      public function SpecialQuestEventChainTabValueObject(param1:SpecialQuestEventChainElementDescription)
      {
         super();
         this.desc = param1;
      }
      
      public static function sort_bySortOrder(param1:CustomSpecialQuestEventChainTabValueObject, param2:CustomSpecialQuestEventChainTabValueObject) : int
      {
         return param1.sortOrder - param2.sortOrder;
      }
      
      public function dispose() : void
      {
      }
      
      public function get name() : String
      {
         return Translate.translate(desc.localeKey);
      }
      
      public function get sortOrder() : int
      {
         return desc.sortOrder;
      }
      
      public function get chainDescription() : SpecialQuestEventChainElementDescription
      {
         return desc;
      }
   }
}
