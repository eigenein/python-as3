package game.mechanics.clan_war.model
{
   import engine.core.utils.property.IntProperty;
   import game.model.user.clan.ClanBasicInfoValueObject;
   
   public class ClanWarParticipantValueObject
   {
       
      
      private var _info:ClanBasicInfoValueObject;
      
      private var _pointsEarned:int;
      
      private var _property_points:IntProperty;
      
      public function ClanWarParticipantValueObject(param1:ClanBasicInfoValueObject, param2:IntProperty)
      {
         super();
         this._property_points = param2;
         this._info = param1;
      }
      
      public function get info() : ClanBasicInfoValueObject
      {
         return _info;
      }
      
      public function get property_points() : IntProperty
      {
         return _property_points;
      }
      
      public function get pointsEarned() : int
      {
         if(_property_points)
         {
            return property_points.value;
         }
         return 0;
      }
   }
}
