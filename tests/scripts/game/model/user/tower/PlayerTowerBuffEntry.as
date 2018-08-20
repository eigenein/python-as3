package game.model.user.tower
{
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerBuffDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTowerBuffEntry
   {
       
      
      private var _bought:Boolean;
      
      private var _buff:TowerBuffDescription;
      
      public const signal_updated:Signal = new Signal();
      
      public function PlayerTowerBuffEntry(param1:* = null)
      {
         super();
         if(param1)
         {
            parseRawData(param1);
         }
      }
      
      public function get id() : int
      {
         return _buff.id;
      }
      
      public function get bought() : Boolean
      {
         return _bought;
      }
      
      public function get buff() : TowerBuffDescription
      {
         return _buff;
      }
      
      public function get needHeroSelection() : Boolean
      {
         return _buff.type == "hero";
      }
      
      public function parseRawData(param1:*) : void
      {
         if(param1)
         {
            _buff = DataStorage.tower.getBuffById(param1.id);
            _bought = param1.bought;
            signal_updated.dispatch();
         }
      }
   }
}
