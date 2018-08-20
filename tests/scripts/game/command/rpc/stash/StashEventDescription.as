package game.command.rpc.stash
{
   public class StashEventDescription
   {
      
      public static const OPENGRAPH_SUCCESS:String = ".client.opengraphSuccess";
      
      public static const OPENGRAPH_ERROR:String = ".client.opengraphError";
      
      public static const WINDOW_OPEN:String = ".client.window.open";
      
      public static const WINDOW_CLOSE:String = ".client.window.close";
      
      public static const BUTTON_CLICK:String = ".client.button.click";
      
      public static const USER_COMPLETE_LOADING:String = ".user.completeLoading";
      
      public static const USER_NOTIFICATION:String = ".user.userNotification";
      
      public static const USER_STORY_POST:String = ".user.storyPost";
       
      
      private var params:StashEventParams;
      
      private var _type:String;
      
      public function StashEventDescription(param1:String, param2:StashEventParams)
      {
         super();
         this._type = param1;
         this.params = param2;
      }
      
      public function get paramsSerialized() : Object
      {
         return params.serialize();
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function addTimestamp(param1:int) : void
      {
         if(params)
         {
            params.timestamp = param1;
         }
      }
   }
}
