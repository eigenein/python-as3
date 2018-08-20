package game.mechanics.clan_war.storage
{
   import game.data.storage.DescriptionBase;
   
   public class ClanWarSlotDescription extends DescriptionBase
   {
      
      public static const TYPE_HERO:String = "hero";
      
      public static const TYPE_TITAN:String = "titan";
       
      
      private var _type:String;
      
      private var _index:int;
      
      private var _fortificationId:int;
      
      private var _fortificationDesc:ClanWarFortificationDescription;
      
      public function ClanWarSlotDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _type = param1.type;
         _fortificationId = param1.fortificationId;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      function internal_setSlotIndex(param1:int) : void
      {
         _index = param1;
      }
      
      public function get fortificationId() : int
      {
         return _fortificationId;
      }
      
      public function get isHeroSlot() : Boolean
      {
         return _type == "hero";
      }
      
      public function get fortificationDesc() : ClanWarFortificationDescription
      {
         return _fortificationDesc;
      }
      
      function internal_setFortificationDesc(param1:ClanWarFortificationDescription) : void
      {
         _fortificationDesc = param1;
      }
   }
}
