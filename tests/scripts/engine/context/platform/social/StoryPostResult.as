package engine.context.platform.social
{
   public class StoryPostResult
   {
      
      public static const CODE_OK:int = 0;
      
      public static const CODE_CANCELED:int = 1;
       
      
      public var story:String;
      
      public var code:int;
      
      public var message:String;
      
      public function StoryPostResult()
      {
         super();
      }
   }
}
