package egovframework.example.cmmn;

public class Paging {
	// 현재 페이지 번호
    private int num;
    // 게시물 총 갯수
    private int count;
    // 한 페이지에 출력할 게시물 갯수
    private int postNum;
    // 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
    private int pageNum;
    // 출력할 게시물
    private int displayPost;
    // 한번에 표시할 페이징 번호의 갯수
    private int pageNumCnt;
    // 페이지 번호 구하기
    private int pageEnd;
    // 표시되는 페이지 번호 중 마지막 번호
    private int endPageNum;
    // 표시되는 페이지 번호 중 첫번째 번호
    private int startPageNum;


    // 다음/이전 표시 여부
    private boolean prev;
    private boolean next;

    public Paging() {
    }

    public void setNum(int num) {
        this.num = num;
    }


    public int getPageEnd() {
        return pageEnd;
    }

    public int getNum() {
        return num;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getCount() {
        return count;
    }




    public void setPostNum(int postNum) {this.postNum = postNum; }

    public int getPostNum() {
        return postNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageNum() {
        return pageNum;
    }

    public int getDisplayPost() {
        return displayPost;
    }


    public void setPageNumCnt(int pageNumCnt) {this.pageNumCnt = pageNumCnt; }

    public int getPageNumCnt() {
        return pageNumCnt;
    }

    public int getEndPageNum() {
        return endPageNum;
    }

    public int getStartPageNum() {
        return startPageNum;
    }

    public boolean getPrev() {
        return prev;
    }

    public boolean getNext() {
        return next;
    }

    public void dataCalc() {

        //pageNumCnt = (int) (Math.ceil((double)(count / (double) postNum)));
        // 마지막 번호
        endPageNum = (int) (Math.ceil((double) num / (double) pageNumCnt) * pageNumCnt);

        // 시작 번호
        startPageNum = endPageNum - (pageNumCnt - 1);

        // 마지막 번호 재계산
//        int endPageNum_tmp = (int) (((double) count / (double) pageNumCnt));
        int endPageNum_tmp = (int) (Math.ceil((double) count / (double) pageNumCnt));

        if (endPageNum > endPageNum_tmp) {
            endPageNum = endPageNum_tmp;
        }
        //페이지 번호구하기
        if(num < 2) {
            pageEnd = postNum;
        } else {
            pageEnd = (num - 1) * postNum;
        }
        prev = startPageNum == 1 ? false : true;
        next = endPageNum * pageNumCnt >= count ? false : true;

        displayPost = (num - 1) * postNum;

    }
}
