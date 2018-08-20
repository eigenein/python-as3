package engine.context.platform
{
   public class PlatformFacadeReferrerInfo
   {
      
      public static const REPLAY_ID:String = "replay_id";
      
      public static const TEST_BATTLE_SETUP:String = "test_battle_setup";
       
      
      public var type:String;
      
      public var id:String;
      
      public var gift_id:String;
      
      public var replay_id:String;
      
      public var test_battle_setup:String;
      
      public function PlatformFacadeReferrerInfo()
      {
         super();
      }
      
      public function get serializedObjectForRPCInit() : Object
      {
         return {
            "type":type,
            "id":id
         };
      }
   }
}
