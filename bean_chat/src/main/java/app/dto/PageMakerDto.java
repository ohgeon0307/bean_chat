package app.dto;

public class PageMakerDto {

	
	private int displayPageNum  = 10;
	private int startPage;
	private int endPage;
	private int totalCount;
	
	private boolean prev;
	private boolean next;
	
	private SearchCriteriaDto scri;

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();  //페이지목록갯수를 나타내주기 위한 계산식
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public SearchCriteriaDto getScri() {
		return scri;
	}

	public void setScri(SearchCriteriaDto scri) {
		this.scri = scri;
	}
	
private void calcData() {
		
		//1.기본적으로 1에서 10까지 나타나게 설정
		endPage = (int)(Math.ceil(scri.getPage()/(double)displayPageNum)*displayPageNum);
		
		//2.endPage를 설정했으면 시작페이지도 설정
		startPage  = (endPage-displayPageNum)+1;
		
		//3.실제 페이지 값을 뽑겠다
		int tempEndPage = (int)Math.ceil(totalCount/(double)scri.getPerPageNum());
		
		//4.설정endPage와 실제endPage 비교한다
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		//5.이전다음버튼 유무
		prev = (startPage ==1 ? false:true);
		next = (endPage*scri.getPerPageNum() >= totalCount ? false:true);
	}
}
