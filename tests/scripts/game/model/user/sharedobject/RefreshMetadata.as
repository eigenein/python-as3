package game.model.user.sharedobject
{
   import com.progrestar.common.util.PropertyMapManager;
   
   public class RefreshMetadata
   {
      
      public static const ACTION_ARENA_BATTLE:String = "arenaBattle";
      
      public static const ACTION_GRAND_BATTLE:String = "grandBattle";
       
      
      public var action:String;
      
      public var replayId:String;
      
      public var arenaOldPlace:int;
      
      public var arenaNewPlace:int;
      
      public function RefreshMetadata()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : RefreshMetadata
      {
         var _loc2_:RefreshMetadata = new RefreshMetadata();
         PropertyMapManager.apply(param1,_loc2_);
         return _loc2_;
      }
      
      public static function arena(param1:String, param2:int, param3:int) : RefreshMetadata
      {
         var _loc4_:RefreshMetadata = new RefreshMetadata();
         _loc4_.action = "arenaBattle";
         _loc4_.replayId = param1;
         _loc4_.arenaOldPlace = param2;
         _loc4_.arenaNewPlace = param3;
         return _loc4_;
      }
      
      public static function grand(param1:Vector.<String>) : RefreshMetadata
      {
         var _loc2_:RefreshMetadata = new RefreshMetadata();
         _loc2_.action = "grandBattle";
         _loc2_.replayId = param1.join(",");
         _loc2_.arenaOldPlace = 0;
         _loc2_.arenaNewPlace = 0;
         return _loc2_;
      }
      
      public function serialize() : Object
      {
         return PropertyMapManager.merge(this);
      }
   }
}
