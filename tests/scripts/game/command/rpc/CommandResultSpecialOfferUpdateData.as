package game.command.rpc
{
   public class CommandResultSpecialOfferUpdateData
   {
       
      
      private var _updated:Array;
      
      private var _ended:Array;
      
      public function CommandResultSpecialOfferUpdateData()
      {
         _updated = [];
         _ended = [];
         super();
      }
      
      public function get updated() : Array
      {
         return _updated;
      }
      
      public function get ended() : Array
      {
         return _ended;
      }
      
      public function addUpdateSpecialOffers(param1:Array) : void
      {
         if(param1)
         {
            _updated = _updated.concat(param1);
         }
      }
      
      public function addEndSpecialOffers(param1:Array) : void
      {
         if(param1)
         {
            _ended = _ended.concat(param1);
         }
      }
   }
}
