package game.view.popup.activity
{
   public class CustomSpecialQuestEventChainTabValueObject extends SpecialQuestEventChainTabValueObject
   {
       
      
      protected var _tab:ISpecialQuestEventCustomTab;
      
      public function CustomSpecialQuestEventChainTabValueObject(param1:ISpecialQuestEventCustomTab)
      {
         super(null);
         _tab = param1;
      }
      
      override public function dispose() : void
      {
         if(_tab)
         {
            _tab.dispose();
         }
      }
      
      override public function get name() : String
      {
         return _tab.name;
      }
      
      override public function get sortOrder() : int
      {
         return _tab.sortOrder;
      }
      
      public function get tab() : ISpecialQuestEventCustomTab
      {
         return _tab;
      }
   }
}
