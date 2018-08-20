package game.command.rpc.stash
{
   import engine.context.platform.social.StoryPostResult;
   
   public class StoryPostStashEventParams extends StashEventParams
   {
       
      
      private var r:StoryPostResult;
      
      public function StoryPostStashEventParams(param1:StoryPostResult)
      {
         super();
         this.r = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {"story":r.story};
         if(r.code)
         {
            _loc1_.code = r.code;
         }
         if(r.message)
         {
            _loc1_.message = r.message;
         }
         return _loc1_;
      }
   }
}
